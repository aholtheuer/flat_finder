<template>
  <nav class="flex items-center justify-between flex-wrap bg-gray-200 p-6">
    <div class="flex items-center flex-no-shrink text-white mr-6">
      <svg class="fill-current h-8 w-8 mr-2" width="54" height="54" viewBox="0 0 54 54" xmlns="http://www.w3.org/2000/svg"><path d="M13.5 22.1c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05zM0 38.3c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05z"/></svg>
      <span class="font-semibold text-xl tracking-tight">FlatFinder</span>
    </div>
    <div class="block">
      <button @click="toggle" class="flex items-center px-3 py-2 border rounded text-teal-lighter border-teal-light hover:text-white hover:border-white">
        [{{ email }}]
      </button>
      <div :class="open ? 'block': 'hidden'" class="w-full flex flex-col px-2 text-sm sm:w-auto">
        <a href="#responsive-header" class="no-underline block mt-4 sm:inline-block sm:mt-0 text-teal-lighter hover:text-white mr-4">
          Docs
        </a>
        <a href="#responsive-header" class="no-underline block mt-4 sm:inline-block sm:mt-0 text-teal-lighter hover:text-white mr-4">
          Examples
        </a>
        <a href="#responsive-header" class="no-underline block mt-4 sm:inline-block sm:mt-0 text-teal-lighter hover:text-white">
          Blog
        </a>
        <a href="#" class="no-underline inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-teal hover:bg-white mt-4 sm:mt-0">
          Download
        </a>

      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'Navbar',
  data: function () {
    return {
      open: false,
      email: "findmyin@nabvar-vue.javascript"
    }
  },
  methods: {
    toggle() {
    	this.open = !this.open
    }
  }
}
</script>
