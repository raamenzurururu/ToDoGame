<template>
  <div>
    <h2>どんどん片付いていく</h2>
    <v-progress-circular
      :rotate="90"
      :size="100"
      :width="15"
      :value="value"
      color="red"
    >
      {{ value }}
    </v-progress-circular>
    <h2>毎日進化する</h2>
    <v-progress-circular
      :rotate="90"
      :size="100"
      :width="15"
      :value="value"
      color="orange"
    >
      {{ value }}
    </v-progress-circular>
    <h2>過去を超えろ</h2>
    <v-progress-circular
      :rotate="90"
      :size="100"
      :width="15"
      :value="value"
      color="blue"
    >
      {{ value }}
    </v-progress-circular>
  </div>
</template>

<script>
export default {
  data() {
    return {
      interval: {},
      value: 0
    };
  },
  beforeDestroy() {
    clearInterval(this.interval);
  },
  mounted() {
    this.interval = setInterval(() => {
      if (this.value === 100) {
        return (this.value = 0);
      }
      this.value += 10;
    }, 1000);
  }
};
</script>

<style scoped>
.v-progress-circular {
  margin: 1rem;
}
</style>
