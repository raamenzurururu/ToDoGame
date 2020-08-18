<template>
  <v-row class="add-reward">
    <v-col class="pr-0 pb-0" cols="4" xs="2" sm="2" md="2" lg="2">
      <v-select
        label="TP"
        v-model="reward.point"
        :items="items"
        outlined
      ></v-select>
    </v-col>
    <v-col class="pl-0 pb-0" cols="8" xs="8" sm="8" md="8" lg="8">
      <v-text-field
        id="reward-title"
        v-model="reward.title"
        :counter="20"
        label="報酬"
        required
        outlined
      >
      </v-text-field>
    </v-col>
    <v-col class="px-0 pb-0" cols="12" xs="2" sm="2" md="2" lg="2">
      <v-hover v-slot:default="{ hover }">
        <v-btn class="reward-btn" @click="handleSubmit">
          <v-icon v-text="hover ? 'mdi-chess-king' : ''"></v-icon>
          登録
        </v-btn>
      </v-hover>
    </v-col>
  </v-row>
</template>
<script>
const numberRange = [...Array(9).keys()].map(i => ++i);
export default {
  props: {
    reward: {
      type: Object,
      default: {
        title: "",
        point: null
      },
      required: true
    }
  },
  data() {
    return {
      items: numberRange
    };
  },
  methods: {
    handleSubmit() {
      const reward = {
        title: this.reward.title,
        user_id: this.$store.state.currentUser.user.id,
        point: this.reward.point
      };
      this.$emit("submit", reward);
      this.reward.title = "";
      this.reward.point = "";
    }
  },
};
</script>

<style lang="scss">
$main-color: yellow;
@mixin btn {
  background-color: black !important;
  border: 2px solid $main-color;
  color: $main-color;
  display: inline-block;
  font-weight: bold;
  font-size: 25px;
  padding-bottom: 35px !important;
  padding-top: 17px !important;
  margin-left: 5%;
  width: 90%;
}
.add-reward {
  .reward-btn {
    @include btn;
    &:hover {
      border: 2px solid yellow;
      color: yellow;
    }
    span {
      margin-top: -9px;
    }
  }
}
</style>