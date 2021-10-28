<template>
  <div class="mt-10 sm:mt-0">
    <div class="md:grid md:grid-cols-3 md:gap-6">
      <div class="mt-5 md:mt-0 md:col-span-2">
        <form action="/api/v1/search_params" method="POST">
          <div class="shadow overflow-hidden sm:rounded-md">
            <div class="px-4 py-5 bg-white sm:p-6">
              
              <div class="grid grid-cols-6 gap-6">
                <div class="col-span-6 sm:col-span-4">
                  <label for="title" class="block text-sm font-medium text-gray-700">Nombre Busqueda</label>
                  <input type="text" name="title" id="title" autocomplete="given-name" placeholder="Ingresa un Nombre para recordar tu busqueda" class="mt-1 w-full py-2 px-3 border border-gray-300 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm rounded-md">
                </div>

                <div class="col-span-6 sm:col-span-4">
                  <label for="comuna" class="block text-sm font-medium text-gray-700">Comuna</label>
                  <select id="comuna" name="comuna" autocomplete="comuna" class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                    <option>Las Condes</option>
                    <option>Vitacura</option>
                  </select>
                </div>

                <div class="col-span-6 sm:col-span-3 lg:col-span-3">
                  <label for="bedroom" class="block text-sm font-medium text-gray-700">Habitaciones</label>
                  <input type="number" name="bedroom" id="bedroom" max="5" min="1" step="1"
                          class="mt-1 py-2 px-3 border border-gray-300 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm rounded-md">
                </div>

                <div class="col-span-6 sm:col-span-3 lg:col-span-3">
                  <label for="bath" class="block text-sm font-medium text-gray-700">Baños</label>
                  <input type="number" name="bath" id="bath" max="5" min="1" step="1"
                          class="mt-1 py-2 px-3 border border-gray-300 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm rounded-md">
                </div>

                <div class="col-span-6 sm:col-span-3 lg:col-span-3">
                  <label for="price_min" class="block text-sm font-medium text-gray-700">Precio Mínimo</label>
                  <input type="number" name="price_min" id="price_min" min="0" step="100000"
                          class="mt-1 py-2 px-3 border border-gray-300 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm rounded-md">
                </div>

                <div class="col-span-6 sm:col-span-3 lg:col-span-3">
                  <label for="price_max" class="block text-sm font-medium text-gray-700">Precio Máximo</label>
                  <input type="number" name="price_max" id="price_max" min="0" step="100000"
                          class="mt-1 py-2 px-3 border border-gray-300 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm rounded-md">
                </div>
              </div>
            </div>
            <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
              <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Save
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
// import axios from "axios";
export default {
  name: 'SpForm',
  data: function () {
    return {
      searchParamObject: {
        title: "",
        comuna: "",
        bedroom: null,
        bath: null,
        price_min: null,
        price_max: null,
      },
    }
  },
}
</script>