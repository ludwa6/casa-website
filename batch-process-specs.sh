#!/usr/bin/env bash
# Batch process all specifications in specs/ folder to generate tasks

set -e

SPECS_DIR="./specs"
TASKS_DIR="./tasks"

echo "🎯 Batch Processing CASA Specifications to Tasks"
echo "================================================="

# Create tasks directory if it doesn't exist
mkdir -p "$TASKS_DIR"

# Count specs to process
spec_count=$(find "$SPECS_DIR" -name "*.md" -not -name "test.md" | wc -l)
echo "Found $spec_count specification files to process..."
echo

# Process each specification file
for spec_file in "$SPECS_DIR"/*.md; do
    # Skip test.md
    if [[ $(basename "$spec_file") == "test.md" ]]; then
        continue
    fi
    
    # Get the base name without extension
    basename=$(basename "$spec_file" .md)
    task_file="$TASKS_DIR/${basename}-tasks.md"
    
    echo "📄 Processing: $(basename "$spec_file")"
    echo "   → Output: $(basename "$task_file")"
    
    # Read the specification content
    spec_content=$(cat "$spec_file")
    
    # Generate tasks based on the specification
    cat > "$task_file" << EOF
# Tasks for ${basename^}

## 📋 Generated from: specs/${basename}.md

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
EOF

    echo "   ✅ Generated $(grep -c "T0" "$task_file") tasks"
    echo
done

echo "🎉 Batch processing complete!"
echo "📁 Task files created in: $TASKS_DIR/"
echo "🔍 Generated files:"
ls -la "$TASKS_DIR"/*-tasks.md 2>/dev/null || echo "   (No task files found)"