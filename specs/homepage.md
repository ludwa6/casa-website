# Spec — Homepage

## Feature Purpose
The homepage is the main entry point for guests, locals, and event bookers.  
Its role is to immediately convey Casa’s brand identity, highlight key offerings (rooms, restaurant, events), and drive visitors toward booking.

## User Stories
- **Guest**: “I want to quickly see photos of the property, understand what Casa offers, and book a room directly.”
- **Local**: “I want to find information about the restaurant menu, opening hours, and events.”
- **Event Booker**: “I want to see if Casa is suitable for hosting an event and find contact details.”
- **SEO/Discovery**: “Search engines should understand what Casa is, where it is, and what it offers.”

## Success Metrics
- Homepage bounce rate < 40%.
- 25% of homepage visitors click into “Book Now” flow.
- SEO: rank in top 3 for “[Casa + city] hotel” and “[Casa + city] restaurant”.

## Content & Sections
1. **Hero Section**  
   - Full-width image or video of Casa property.  
   - Headline: tagline (from Brand Kit).  
   - Call-to-action button: **Book Now**.  

2. **About Casa (intro text)**  
   - 2–3 sentences introducing Casa’s unique value proposition.  
   - “More about us” link to dedicated About page.

3. **Rooms & Stays teaser**  
   - Carousel or 2–3 highlighted room types with photos.  
   - CTA: “View Rooms”.

4. **Restaurant teaser**  
   - High-quality food image, short description.  
   - CTA: “See Menu & Book Table”.

5. **Events & Gatherings teaser**  
   - Showcase venue/event space.  
   - CTA: “Host Your Event”.

6. **Guest Reviews / Social Proof**  
   - Pull from Google Reviews, Booking.com, or direct testimonials.

7. **Call-to-Action Banner**  
   - Sticky or repeated “Book Now” with special offer highlight.

8. **Footer**  
   - Contact info (address, phone, email).  
   - Social media links.  
   - Newsletter signup.  

## Functional Requirements
- Mobile-first responsive design (optimized for small screens).  
- Hero image/video loads fast (< 2s on mobile 4G).  
- Booking button links into PMS/engine (Host/Cloudbeds).  
- SEO metadata (title, description, OpenGraph tags).  
- ADA/WCAG 2.1 AA accessibility compliance.

## Integrations
- PMS/Booking engine (Host or Cloudbeds).  
- Optional: newsletter system (Mailchimp, Brevo).  
- Optional: Instagram feed embed.  

## Brand / Visual Requirements
- Follow Casa’s Brand Kit (typography, color palette, logo).  
- Photography should reflect real property (no stock hotel images).  
- Layout should feel modern, calm, and trustworthy.  

## Risks & Constraints
- Large media assets could slow page load → require optimization (WebP, lazy loading).  
- PMS booking widget styling may be hard to brand-match.  
- Restaurant info must stay updated (menu changes).  

## Open Questions
- Do we want multi-language support at launch? (e.g., English + Portuguese).  
- Should homepage prioritize **stays** or **restaurant** first?  
- Will Casa staff manage content via CMS (WordPress, Headless) or static edits?  

