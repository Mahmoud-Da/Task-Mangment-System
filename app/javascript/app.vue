<template>
  <div class="dodo">
    <VueMultiselect
      v-model="value"
      :options="options.map(option => option.name)"
      :multiple="true"
      placeholder="カテゴリーを選択してください">
    </VueMultiselect>
  </div>
</template>

<script>
import VueMultiselect from 'vue-multiselect'
export default {
  components: { VueMultiselect },
  data() {
      return {
        value: [],
        options: []
      }
    },
    methods: {
      async getData() {
        const res = await fetch("http://localhost:3000/api/v1/categories?get.value");
        const finalRes = await res.json();
        this.options = finalRes;
      }
    },
    async submitData() {
      const response = await fetch('http://localhost:3000/api/v1/tasks', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(this.options)
      })
      const json = await response.json()
      console.log(json)
    },
    mounted() {
      this.getData();
    }
  }
</script>

<style>
  @import 'vue-multiselect/dist/vue-multiselect.css';
</style>
