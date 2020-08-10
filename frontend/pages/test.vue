<template>
  <v-hover v-slot:default="{ hover }">
      <v-icon v-text="hover ? 'mdi-crown' : 'mdi-heart'"></v-icon>
  </v-hover>
</template>
