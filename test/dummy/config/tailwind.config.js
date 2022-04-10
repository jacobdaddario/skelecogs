const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './test/components/**/*.{rb,erb,html}',
    './app/views/**/*.{erb,haml,html,slim}',
    // I kind of hate this, but I realized this was the issue after about an hour of tinkering
    // and then I spent like 4 hours source diving into Rails to try to find where the test
    // task defines the compilation step, ultimately failing... This'll have to work for now
    './test/dummy/app/helpers/**/*.rb',
    './test/dummy/app/javascript/**/*.js',
    './test/dummy/test/components/**/*.{rb,erb,html}',
    './test/dummy/app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
