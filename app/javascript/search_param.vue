<template>
  <div class="flex flex-nowrap justify-start bg-gray-100 mt-10 m-b5 mr-10 ml-5 md:w-max gap-2 p-10 rounded-xl hover:bg-gray-200">
    
    <div class='flex-grow-0 sm:w-44 font-black'>
      {{ searchParamObject.title }}
    </div>
    <div class="flex flex-col gap-4 justify-start"> 
      <div class='flex flex-wrap gap-6 justify between text-sm sm:text-center content-between'>
        <div >
          <p class="font-black text-gray-600">  Comuna </p> 
          <p> {{ searchParamObject.comuna }}  </p>
        </div>

        <div v-if="searchParamObject.bedroom !== null" > 
          <p class="font-black text-gray-600">  Habitaciones </p> 
          <p> {{ searchParamObject.bedroom }}  </p>
        </div>

        <div v-if="searchParamObject.bath !== null" >
          <p class="font-black text-gray-600">  Baños </p> 
          <p> {{ searchParamObject.bath }}  </p>
        </div>

        <div v-if="searchParamObject.price_min !== null" >
          <p class="font-black text-gray-600">  Precio Min </p> 
          <p> ${{ Intl.NumberFormat('de-DE').format(searchParamObject.price_min) }}  </p>
        </div>

        <div v-if="searchParamObject.price_max !== null" >
          <p class="font-black text-gray-600">  Precio Max </p> 
          <p> ${{ Intl.NumberFormat('de-DE').format(searchParamObject.price_max) }}  </p>
        </div>
      </div>
        
      <div class="flex flex-rows flex-wrap gap-1 ">
        <a class="bg-blue-400 hover:bg-blue-600 place-self-center text-white font-black rounded-lg text-xs text-center px-2 py-2" :href="`/search_params/${searchParamObject.id}`">
          Ver Flats!
        </a>
        <a class="bg-blue-400 hover:bg-blue-600 place-self-center text-white font-black rounded-lg text-xs text-center px-2 py-2" :href="`/search_params/${searchParamObject.id}/edit`">
          Editar
        </a>
        <button v-on:click="deleteSearchParam()" 
            class="bg-red-400 hover:bg-red-600 place-self-center text-white font-black rounded-lg text-xs text-center px-2 py-2" >
          <span>Delete</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: 'SearchParam',
  data: function () {
    return {
      searchParamObject: {},
    }
  },
  props: {
    search_param_json: String,
  },
  created() {
    this.searchParamObject = JSON.parse(this.search_param_json)
  },
  methods: {
    deleteSearchParam() {
      confirm("Are you sure you want to delete this search?"); 
      console.log(`Delete`)
      axios
        .delete(`http://localhost:3000/api/v1/search_params/${this.searchParamObject.id}`)
        .then(response => {
          console.log(response);
          console.log(response.data);
          window.location.href = `/users/${response.data.user_id}`
          })
        .catch(error => {
          console.log('error')
          console.log(error);
          console.log(error.response);
          console.log(error.response);
        });
    }
  }
}
</script>