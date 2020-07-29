<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="12" md="5">
          <v-text-field
            v-model="title"
            :rules="[v => !!v || 'まだまだいけるよ！']"
            :counter="15"
            label="やるべきこと"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-btn @click="handleSubmit">作成</v-btn>
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
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    handleSubmit() {
      const todo = {
        title: this.title,
        user_id: this.user.id
      };
      this.$emit("submit", todo);
      this.title = "";
    }
  }
};
</script>

<style>
</style>