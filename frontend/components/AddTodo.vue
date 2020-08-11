<template>
  <v-form>
    <v-container class="add-todo">
      <v-row>
        <v-col class="pr-0" cols="2" xs="6" sm="6" md="1" lg="1">
          <v-select label="TP" v-model="number" :items="items">Point</v-select>
        </v-col>
        <!-- v-bind: 属性名 = "設定する値" -->
        <v-col class="pr-0" cols="10" xs="6" sm="6" md="4" lg="7">
          <v-text-field
            v-model="title"
            :rules="[v => !!v || 'まだまだいけるよ！']"
            :counter="15"
            label="やるべきこと"
            required
          ></v-text-field>
        </v-col>
        <v-col class="pr-0" cols="10" xs="6" sm="6" md="4" lg="4">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="todo-btn" @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-star' : ''"></v-icon>Press
            </v-btn>
          </v-hover>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()]; //スプレッド演算子

export default {
  data() {
    return {
      title: "",
      items: numberRange,
      number: ""
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

<style lang="scss">
$main-color: deeppink;

@mixin btn {
  background-color: white;
  border: 2px solid $main-color;
  color: $main-color;
  display: inline-block;
  margin: 15px;
  width: 50%;
}

.add-todo {
  border: 2px white solid;

  .todo-btn {
    @include btn;

    &:hover {
      border: 2px solid blue;
      color: white
    }
  }

  .mdi-star {
    color: red !important;
  }
}

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
