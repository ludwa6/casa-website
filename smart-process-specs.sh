#!/usr/bin/env bash
# Smart batch processor - only updates tasks when specs are newer

set -e

SPECS_DIR="./specs"
TASKS_DIR="./tasks"
FORCE_ALL=false

# Parse command line arguments
for arg in "$@"; do
    case $arg in
        --force|-f)
            FORCE_ALL=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--force|-f] [spec-name]"
            echo "  --force    Regenerate all task files"
            echo "  spec-name  Only process specific spec (without .md extension)"
            echo ""
            echo "Examples:"
            echo "  $0                    # Process only changed specs"
            echo "  $0 --force           # Regenerate all task files"
            echo "  $0 overview          # Only process overview.md"
            exit 0
            ;;
        *)
            SPECIFIC_SPEC="$arg"
            ;;
    esac
done

echo "🎯 Smart Processing CASA Specifications to Tasks"
echo "================================================"

# Create tasks directory if it doesn't exist
mkdir -p "$TASKS_DIR"

# Function to check if spec is newer than task file
is_spec_newer() {
    local spec_file="$1"
    local task_file="$2"
    
    # If task file doesn't exist, spec is "newer"
    if [[ ! -f "$task_file" ]]; then
        return 0
    fi
    
    # Compare modification times
    if [[ "$spec_file" -nt "$task_file" ]]; then
        return 0
    else
        return 1
    fi
}

# Function to generate task file from spec
generate_tasks() {
    local spec_file="$1"
    local basename="$2"
    local task_file="$3"
    
    echo "   🔄 Generating tasks..."
    
    # Read the specification content
    spec_content=$(cat "$spec_file")
    
    # Generate tasks based on the specification
    cat > "$task_file" << EOF
# Tasks for ${basename^}

## 📋 Generated from: specs/${basename}.md
**Last Updated**: $(date)

### 🎯 Overview
Based on the specification for ${basename}, here are the actionable development tasks:

## Setup Tasks
- [ ] **T001**: Create ${basename} directory structure
- [ ] **T002**: Set up basic HTML template for ${basename}
- [ ] **T003**: Initialize CSS styling framework

## Content & Structure Tasks
EOF

    # Extract user stories and requirements from the spec to generate tasks
    if grep -q "User Stories" "$spec_file"; then
        echo "- [ ] **T004**: Implement user story requirements" >> "$task_file"
    fi
    
    if grep -q "Content & Sections" "$spec_file"; then
        echo "- [ ] **T005**: Build content sections as specified" >> "$task_file"
    fi
    
    if grep -q "Functional Requirements" "$spec_file"; then
        echo "- [ ] **T006**: Implement functional requirements" >> "$task_file"
        echo "  - Mobile-first responsive design" >> "$task_file"
        echo "  - Performance optimization" >> "$task_file"
        echo "  - Accessibility compliance" >> "$task_file"
    fi
    
    if grep -q "Integrations" "$spec_file"; then
        echo "- [ ] **T007**: Set up required integrations" >> "$task_file"
    fi
    
    # Add testing and deployment tasks
    cat >> "$task_file" << EOF

## Testing Tasks
- [ ] **T008**: Create unit tests for ${basename} functionality
- [ ] **T009**: Perform cross-browser testing
- [ ] **T010**: Validate accessibility compliance (WCAG 2.1 AA)

## Polish Tasks
- [ ] **T011**: Optimize images and assets for ${basename}
- [ ] **T012**: SEO optimization (meta tags, structured data)
- [ ] **T013**: Performance testing and optimization

## Documentation
- [ ] **T014**: Document ${basename} implementation
- [ ] **T015**: Create deployment checklist

---
**Generated**: $(date)
**Source**: specs/${basename}.md
**Spec Modified**: $(stat -c %y "$spec_file" 2>/dev/null || stat -f %Sm "$spec_file" 2>/dev/null || echo "unknown")
EOF

    local task_count=$(grep -c "T0" "$task_file")
    echo "   ✅ Generated $task_count tasks"
}

# Count total specs
total_specs=$(find "$SPECS_DIR" -name "*.md" -not -name "test.md" | wc -l)
processed_count=0
skipped_count=0
updated_count=0

echo "Found $total_specs specification files"
echo

# Process files
if [[ -n "$SPECIFIC_SPEC" ]]; then
    # Process specific spec
    spec_file="$SPECS_DIR/${SPECIFIC_SPEC}.md"
    if [[ ! -f "$spec_file" ]]; then
        echo "❌ Error: $spec_file not found"
        exit 1
    fi
    
    task_file="$TASKS_DIR/${SPECIFIC_SPEC}-tasks.md"
    echo "📄 Processing specific: $(basename "$spec_file")"
    generate_tasks "$spec_file" "$SPECIFIC_SPEC" "$task_file"
    echo "   ✅ Complete"
else
    # Process all specs (with smart updates)
    for spec_file in "$SPECS_DIR"/*.md; do
        # Skip test.md
        if [[ $(basename "$spec_file") == "test.md" ]]; then
            continue
        fi
        
        basename=$(basename "$spec_file" .md)
        task_file="$TASKS_DIR/${basename}-tasks.md"
        
        echo "📄 Checking: $(basename "$spec_file")"
        
        if $FORCE_ALL || is_spec_newer "$spec_file" "$task_file"; then
            echo "   → Needs update (spec is newer)"
            generate_tasks "$spec_file" "$basename" "$task_file"
            updated_count=$((updated_count + 1))
        else
            echo "   → ⏭️  Skipping (task file is up to date)"
            skipped_count=$((skipped_count + 1))
        fi
        
        processed_count=$((processed_count + 1))
        echo
    done
fi

echo "🎉 Processing complete!"
echo "📊 Summary:"
echo "   📄 Total specs checked: $processed_count"
echo "   🔄 Updated: $updated_count"
echo "   ⏭️  Skipped: $skipped_count"
echo
echo "💡 Tips:"
echo "   • Edit a spec file, then run this script to update only that task file"
echo "   • Use --force to regenerate all task files"
echo "   • Use 'overview' to process only overview.md"