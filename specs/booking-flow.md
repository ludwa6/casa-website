# Spec — Booking Flow

## Feature Purpose
Provide a seamless, branded path from Casa website into PMS booking engine.

## User Stories
- As a guest, I want booking to feel consistent with Casa’s site.  
- As staff, I want fewer abandoned bookings due to confusing flows.  

## Success Metrics
- Booking completion rate > 70%.  
- Fewer than 10% drop-offs after “Book Now” click.  

## Flow
1. **CTA from homepage/rooms → Book Now.**  
2. **Booking widget overlay or redirect to PMS.**  
3. **Guest completes booking.**  

## Functional Requirements
- Integrate PMS (Host/Cloudbeds).  
- Styling match (fonts, colors, logo).  
- Support for promo codes.  

## Integrations
- PMS/Booking engine (mandatory).  
- Payment processor (via PMS).  

## Brand / Visual
- Booking button should be consistent across all pages.  

## Risks & Constraints
- PMS styling limitations may reduce brand control.  
- PMS downtime = no bookings.  

## Open Questions
- Overlay vs full redirect — which provides better UX?  
- Should booking confirmation emails include Casa branding?
