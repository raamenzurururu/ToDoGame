<template>
  <v-form>
    <v-row class="add-reward">
      <v-col class="pr-0" cols="3" xs="6" sm="2" md="2" lg="2">
        <!-- <v-btn label="コイン" v-model="point" :items="items" outlined></v-btn> -->
        <!-- ランダムで数字が選ばれるようにしたい -->
        <span>値段を決める</span>
        <v-hover v-slot:default="{ hover }">
          <v-icon
            @click="randomPoint()"
            size="50px"
            color="white"
            v-text="hover ? 'mdi-cube-send' : 'mdi-dice-3-outline'"
          >
          </v-icon>
        </v-hover>
      </v-col>
      <v-col class="pr-0" cols="9" xs="8" sm="8" md="8" lg="8">
        <v-text-field
          v-model="title"
          :counter="20"
          label="報酬"
          required
          outlined
        >
        </v-text-field>
      </v-col>
      <v-col class="pr-0" cols="12" xs="2" sm="2" md="2" lg="2">
        <v-btn class="reward-btn" @click="handleSubmit">
          登録
        </v-btn>
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
const minNumber = 1;
const maxNumber = 20;
const randomPoint = Math.floor(Math.random() * 21);

export default {
  props: ["reward"],
  data() {
    return {
      items: randomPoint,
      title: "",
      point: ""
    };
  },
  methods: {
    handleSubmit() {
      const reward = {
        title: this.title,
        user_id: this.$store.state.currentUser.user.id,
        point: this.point
      };
      this.$emit("submit", reward);
      this.title = "";
      this.point = "";
    },
    randomPoint() {
      console.log(randomPoint);
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;

@mixin btn {
  background-color: white;
  border: 2px solid white;
  color: white;
  display: inline-block;
  font-weight: bold;
  margin: 15px;
  width: 93%;
}

.add-reward {
  .reward-btn {
    @include btn;
    &:hover {
      border: 2px solid blue;
      color: rgba(8, 113, 233, 0.884);
    }
  }
}

.col-md-4 > .bt {
  color: white;
  padding: 10px 40px !important;
  border: 2px solid white;
}
</style>
