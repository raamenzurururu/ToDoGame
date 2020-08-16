<template>
  <v-form>
    <v-container class="add-reward">
      <v-row>
        <v-col class="pr-0" cols="3" xs="6" sm="2" md="1" lg="1">
          <v-select label="TP" v-model="reward.point" :items="items">You</v-select>
        </v-col>
        <v-col class="pr-0" cols="9" xs="5" sm="6" md="7" lg="7">
          <v-text-field
            v-model="reward.title"
            :counter="20"
            label="reward"
            required
          ></v-text-field>
        </v-col>
        <v-col class="pr-0" cols="12" xs="6" sm="4" md="4" lg="4">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="reward-btn" @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-star' : ''">
                </v-icon>
                Press
            </v-btn>
          </v-hover>
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
      rewuired: true
    }
  },
  data() {
    return {
      items: numberRange,
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
      color: white
    }
  }
}
</style>
