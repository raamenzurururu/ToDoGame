<template>
  <v-form>
    <v-container class="add-todo">
      <v-row>
        <v-col id="v-step-0" class="pr-0" cols="3" xs="6" sm="2" md="1" lg="2">
          <v-select label="TP" v-model="todo.point" :items="items" outlined>Point</v-select>
        </v-col>
        <!-- v-bind: 属性名 = "設定する値" -->
        <v-col class="pr-0" cols="9" xs="8" sm="8" md="8" lg="8">
          <v-text-field
            v-model="todo.title"
            :rules="[v => !!v || 'まだまだいけるよ！']"
            :counter="15"
            label="やるべきこと"
            required
            outlined
          ></v-text-field>
        </v-col>
        <v-col class="pr-0" cols="12" xs="2" sm="2" md="2" lg="2">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="todo-btn" my-2 mx-1 @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-chess-king' : ''">
                </v-icon>
                POST
            </v-btn>
          </v-hover>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()]; 

export default {
  props: {
    todo: {
      type: Object,
      'default': () => ({ title:"",point: 0}) ,
      required: true
    }
  },
  data() {
    return {
      items: numberRange,
    };
  },
  methods: {
    handleSubmit() {
      const todo = {
        title: this.todo.title,
        user_id: this.$store.state.currentUser.user.id,
        point: this.todo.point
      };
      this.$emit("submit", todo);
      this.todo.title = "";
      this.todo.point = "";
    }
  }
};
</script>

<style lang="scss">
$main-color: yellow;

@mixin btn {
  background-color: white;
  border: 2px solid $main-color;
  color: $main-color;
  display: inline-block;
  font-weight: bold;
  margin: 15px;
  width: 93%;
}

.add-todo {

  .todo-btn {
    @include btn;

    &:hover {
      border: 2px solid blue;
      color: white
    }
  }

  .mdi-chess-king {
    color: black !important;
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
