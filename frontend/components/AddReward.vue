<template>
  <v-row class="add-reward">
    <v-col class="pr-0" cols="3" xs="6" sm="2" md="2" lg="2">
      <v-select
        label="TP"
        v-model="reward.point"
        :items="items"
        outlined
      ></v-select>
    </v-col>
    <v-col class="pr-0" cols="9" xs="8" sm="8" md="8" lg="8">
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
    <v-col class="pr-0" cols="12" xs="2" sm="2" md="2" lg="2">
        <v-btn class="reward-btn" @click="handleSubmit">
          登録
        </v-btn>
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
    span {
      margin-top: -9px;
    }
  }
}
</style>