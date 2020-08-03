<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="2" xs="6" sm="6" md="1" lg="1">
          <v-select label="TP" v-model="number" :items="items">Point</v-select>
        </v-col>                         <!-- v-bind: 属性名 = "設定する値" --> 
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
          <v-btn class="bt" @click="handleSubmit">作成</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()] //スプレッド演算子

export default {
  data() {
    return {
      title: "",
      items: numberRange,
      number: ''
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
        user_id: this.user.id,
        point: this.number
      };
      this.$emit("submit", todo);
      this.title = "";
      this.number = "";
    }
  }
};
</script>

<style>
.col-md-4 > .bt {
  color: white;
  padding: 10px 40px !important;
  border: 2px solid white;
}

.bt:hover {
  color: yellow;
  border: 2px solid yellow;
}
</style>