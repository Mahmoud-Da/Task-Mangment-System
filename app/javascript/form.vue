<template>
<div class="center">
    <form>
        <label class="px-x">
            <input v-model="title" type="text" class="form-control" id="exampleFormControlInput1" placeholder="タイトル" />
        </label>
    <br />
        <label class="px-x">
            <input v-model="body" type="text" class="form-control" id="exampleFormControlInput1" placeholder="内容" />
        </label>
    <br />
        <label class="px-x">
            <VueMultiselect
            v-model="selectedStatus"
            :options="[
                { value: 0, label: '未着' },
                { value: 1, label: '着手'},
                { value: 2, label: '完了' },
            ]"
            label="label"
            value="value"
            :multiple="false"
            placeholder="ステータス">
            </VueMultiselect>
        </label>
    <br />
    <label>
            <VueMultiselect
            v-model="selectedPriority"
            :options="[
                { value: 0, label: '低' },
                { value: 1, label: '中'},
                { value: 2, label: '高' },
            ]"
            label="label"
            value="value"
            :multiple="false"
            placeholder="優先度">
            </VueMultiselect>
        </label>
    <br />
        <label class="px-x">
            <input v-model="limit" type="text" class="form-control" id="exampleFormControlInput1" onfocus="(this.type='date')" onblur="if(!this.value) this.type='text';" placeholder="期限選択　🕐" />
        </label>
    <br />
        <label>
            <VueMultiselect
            v-model="selectedCategories"
            :options="options"
            label="name"
            value="value"
            :multiple="true"
            placeholder="カテゴリー">
            </VueMultiselect>
        </label>
    <br>
    <br />
        <button class="btn btn-outline-success" @click="submitForm">更新</button>
    </form>
</div>
  </template>

  <script>
  import VueMultiselect from 'vue-multiselect'
  import axios from 'axios'

  export default {
    components: { VueMultiselect },
    data() {
        return {
            selectedCategories: [],
            selectedPriority: [],
            selectedStatus: [],
            options: [],
            taskId: null,
        }
        },
    methods: {
        async getData() {
            const res = await fetch("http://localhost:3000/api/v1/categories?get.value");
            const finalRes = await res.json();
            this.options = finalRes;
      },
        async submitForm() {
    try {
        let response;
        if (this.taskId) {
        response = await axios.put(`http://localhost:3000/api/v1/tasks/${this.taskId}`, {
            task: {
            title: this.title,
            body: this.body,
            status: this.selectedStatus.value,
            priority: this.selectedPriority.value,
            limit: this.limit,
            category_ids: this.selectedCategories.map(category => category.id)
            }
        });
        } else {
        response = await axios.post('http://localhost:3000/api/v1/tasks', {
            task: {
            title: this.title,
            body: this.body,
            status: this.selectedStatus.value,
            priority: this.selectedPriority.value,
            limit: this.limit,
            category_ids: this.selectedCategories.map(category => category.id)
            }
        });
        }
        console.log(response)
        window.location.href = 'http://localhost:3000/tasks';
    } catch (error) {
        console.error(error)
    }
    },
    },
    created() {
    // ここでurlがeditであればapiコントローラーのeditを叩く
      if (window.location.href.includes('edit')) {
        axios.get(`http://localhost:3000/api/v1/tasks/${window.location.pathname.split('/')[2]}/edit`)
          .then((response) => {
            this.taskId = window.location.pathname.split('/')[2];
            this.title = response.data.title;
            this.body = response.data.body;
            this.status = response.data.status;
            this.priority = response.data.priority;
            this.limit = response.data.limit;
            this.category_ids = response.data.category;
          });
      }
    },
    mounted() {
        this.getData()
        }
    }
  </script>
<style>
@import 'vue-multiselect/dist/vue-multiselect.css';
</style>
