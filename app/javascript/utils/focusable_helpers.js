export const focusableElements = [
  '[contentEditable=true]',
  '[tabindex]',
  'a[href]',
  'area[href]',
  'button:not([disabled])',
  'iframe',
  'input:not([disabled])',
  'select:not([disabled])',
  'textarea:not([disabled])'
]

export function isFocusableElement(element) {
  let next = element

  // Originally wasn't in love with this solution when I thought of it,
  // but I did some source diving and HeadlessUI React does the same thing.
  // If it's good enough for the Tailwind team, it's good enough for me.
  while (next !== null) {
    if (next.matches(focusableElements.join(", "))) return true
    next = next.parentElement
  }

  return false
}
