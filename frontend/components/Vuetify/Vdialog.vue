<template>
  <div>
    <v-btn>
      <v-hover v-slot:default="{ hover }">
        <v-icon
          :disabled="dialog"
          :loading="dialog"
          @click="dialog = true"
          color="red"
          v-text="hover ? 'mdi-heart-multiple' : 'mdi-heart-multiple-outline'"
        >
        </v-icon>
      </v-hover>
    </v-btn>

    <v-dialog v-model="dialog" hide-overlay persistent width="300">
      <v-card color="green" dark>
        <v-card-text>
          休憩してね♪
          <v-progress-linear
            indeterminate
            color="white"
            class="mb-0"
          ></v-progress-linear>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false
    };
  },

  watch: {
    dialog(val) {
      if (!val) return;

      setTimeout(() => (this.dialog = false), 4000);
    }
  }
};
</script>

<style lang="scss" scoped>

</style>
