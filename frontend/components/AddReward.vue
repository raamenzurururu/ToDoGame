<template>
  <v-form>
    <v-container class="add-reward">
      <v-row>
        <v-col class="pr-0 pb-0" cols="3" xs="2" sm="2" md="2" lg="2">
          <v-select
            label="TP"
            v-model="reward.point"
            :items="items"
            outlined
          ></v-select>
        </v-col>
        <v-col class="pl-0 pb-0" cols="9" xs="8" sm="8" md="8" lg="8">
          <v-text-field
            v-model="reward.title"
            :counter="20"
            label="報酬"
            required
            outlined
          ></v-text-field>
        </v-col>
        <v-col class="px-0 pb-0" cols="12" xs="12" sm="2" md="2" lg="2">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="reward-btn" my-2 mx-1 @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-star' : ''"> </v-icon>
              登録
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
    reward: {
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
  font-weight: bold;
  margin: 15px;
  width: 50%;
}

.add-reward {
  border: 2px white solid;

  .reward-btn {
    @include btn;

    &:hover {
      border: 2px solid blue;
      color: white;
    }
  }
}
</style>
