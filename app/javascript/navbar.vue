<template>
  <nav class="flex items-center justify-between flex-wrap bg-gray-200 p-6 mb-4">
    <div class="flex justify-start">
      <a href="/">
        <div class="flex items-center flex-no-shrink text-white mr-6">
          <svg class="fill-current h-8 w-8 mr-2" width="54" height="54" viewBox="0 0 54 54" xmlns="http://www.w3.org/2000/svg"><path d="M13.5 22.1c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05zM0 38.3c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05z"/></svg>
          <span class="font-semibold text-xl tracking-tight">FlatFinder</span>
        </div>
      </a>

      <div  v-if="userObject !== null" class="py-2 text-sm">
        <a :href="`/users/${userObject.id}`"  class="px-1 hover:text-white ">
          Searches
        </a>
        <a href="/users/sign_out"  class="px-1 hover:text-white ">
          Log Out
        </a>
        <a href="/favorites"  class="px-1 hover:text-white ">
          Favoritos
        </a>
      </div>

    </div>

    <div v-if="userObject !== null" class="flex flex-col">

      <button @click="toggle" class="flex items-center px-3 py-2 border rounded text-teal-lighter border-teal-light hover:text-white hover:border-white">
        {{ userObject.email }}
      </button>
      <div :class="open ? 'block': 'hidden'" class="w-full flex flex-col px-4 text-sm sm:w-auto">
        <a href= "/users/edit" class="no-underline block mt-4 sm:inline-block sm:mt-0 text-teal-lighter hover:text-white mr-4">
          Edit your Profile
        </a>
        <button v-on:click="deleteUser()" class="no-underline block mt-4 text-left sm:inline-block sm:mt-0 text-teal-lighter hover:text-white hover:bg-red-600 mr-4">
          Cancel your Subscription
        </button>
      </div>
    </div>
  </nav>
</template>

<script>
import ax from 'packs/axios';
export default {
  name: 'Navbar',
  data: function () {
    return {
      open: false,
      userObject: {},
    }
  },
  props: {
    user_id: String,
    user_json: String
  },
  created() {
    this.userObject = JSON.parse(this.user_json)
  },
  methods: {
    toggle() {
    	this.open = !this.open
    },
    deleteUser() {
      if(confirm("Do you really want to delete?")){
        ax
          .delete(`http://localhost:3000/api/v1/users/${this.userObject.id}`)
          .then(response => {
            console.log(response);
            console.log(response.data);
            window.location.href = `/users/sign_in`
            })
          .catch(error => {
            console.log('error')
            console.log(error);
            console.log(error.response);
            console.log(error.response.data);
          });
      }
    },
  }
}
</script>
