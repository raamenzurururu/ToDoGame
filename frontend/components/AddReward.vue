<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="2" xs="6" sm="6" md="1" lg="1">
          <v-select label="TP" v-model="number" :items="items">You</v-select>
        </v-col>
        <v-col cols="10" xs="6" sm="6" md="4" lg="4">
          <v-text-field
            v-model="title"
            :counter="20"
            label="reward"
            required
          ></v-text-field>
        </v-col>
        <v-col cols="12" xs="6" sm="6" md="4" lg="4">
          <v-btn class="bo" @click="handleSubmit">Shining</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()];

export default {
  data() {
    return {
      title: "",
      // ここからタスクポイントに関する記述
      items: numberRange,
      number: ""
    };
  },
  methods: {
    handleSubmit() {
      const reward = {
        title: this.title,
        user_id: this.$store.state.currentUser.id,
        point: this.number
      };
      this.$emit("submit", reward);
      this.title = "";
      this.number = "";
    }
  }
};
</script>

<style>
.col-md-4 > .bo {
  color: pink;
  padding: 10px 40px !important;
  border: 2px solid deeppink;
  background-color: black !important;
  margin: 0 auto !important;
}
.bo:hover {
  border: 2px solid yellow;
  color: yellow;
}
</style>
