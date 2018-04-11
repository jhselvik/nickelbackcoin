import Vue from 'vue'
import App from './App.vue'
import router from './router/index'

// Create the app instance. Inject the router, store and ssr context to all child components,
// making them available everywhere as `this.$router` and `this.$store`.
// Instance properties - https://vuejs.org/v2/api/#Instance-Properties
// Render function, a closer-to-the-compiler alternative to templates
// https://vuejs.org/v2/guide/render-function.html
// Hyperscript stands for "script that generates HTML structures"
// render: h => h(App); Aliasing createElement to h 
// https://github.com/vuejs-templates/webpack-simple/issues/29#issuecomment-312902539
new Vue({ // eslint-disable-line no-new
  router,
  render: h => h(App)
}).$mount('#app') // .$mount === el: '#app'
