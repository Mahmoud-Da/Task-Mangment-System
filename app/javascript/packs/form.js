import { createApp } from 'vue'
import Form from '../form.vue'

document.addEventListener("DOMContentLoaded", () => {
    const app = createApp(Form);
    app.mount("#form");
});