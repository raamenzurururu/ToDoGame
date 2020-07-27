<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="12" md="4">
          <v-text-field
            v-model="title"
            :counter="15"
            label="やるべきこと"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-btn @click="handleSubmit">よいしょ！</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>
<script>
export default {
  data() {
    return {
      title: ""
    };
  },
  methods: {
    handleSubmit() {
      this.$emit("submit", this.title);
      this.title = "";
    }
  }
};
</script>

<style></style>
