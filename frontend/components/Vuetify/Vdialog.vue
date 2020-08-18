<template>
  <div>
    <v-btn class="header-btn ml-1" @click="logOutWindow = true">
      <v-hover v-slot:default="{ hover }">
        <v-icon
          :disabled="dialog"
          :loading="dialog"
          @click="dialog = true"
          size="20px"
          color="orange"
          v-text="hover ? 'mdi-coffee-to-go' : 'mdi-coffee'"
        >
        </v-icon>
      </v-hover>
    </v-btn>

    <v-dialog v-model="dialog" hide-overlay persistent width="300">
      <v-card color="primary" dark>
        <v-card-text>
          Please stand by
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
