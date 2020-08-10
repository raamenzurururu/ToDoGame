<template>
  <div class="hello">
    <p>{{ message }}</p>
    <div>
      <input type="text" v-model="input">
      <button @click="doAction">Click</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "お名前は?",
      input: " "
    };
  },
  methods: {
    doAction() {
      this.message = "Hello," + this.input + "さん！";
    }
  }
};
</script>
