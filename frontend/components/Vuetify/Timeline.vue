<template>
  <v-timeline>
    <v-timeline-item>
      <template v-slot:icon>
        <v-avatar>
          <img src="yuusya.png">
        </v-avatar>
      </template>
      <template v-slot:opposite>
        <span>タスクをどんどんこなそう</span>
      </template>
      <v-card class="elevation-2">
        <v-card-title class="headline">君のペースで</v-card-title>
        <v-card-text>どんなタスクでも楽しくやれば終わる！</v-card-text>
      </v-card>
    </v-timeline-item>
    <v-timeline-item>
      <template v-slot:icon>
        <v-avatar>
          <img src="d-king01.png">
        </v-avatar>
      </template>
      <template v-slot:opposite>
        <span>罰ゲームをつけてより楽しく</span>
      </template>
      <v-card class="elevation-2">
        <v-card-title class="headline">楽ばかりではない</v-card-title>
        <v-card-text>罰があることでより自分を高める</v-card-text>
      </v-card>
    </v-timeline-item>
    <v-timeline-item>
      <template v-slot:icon>
        <v-avatar>
          <img src="magic.png">
        </v-avatar>
      </template>
      <template v-slot:opposite>
        <span>完了した喜びを</span>
      </template>
      <v-card class="elevation-2">
        <v-card-title class="headline">報酬をゲットしよう</v-card-title>
        <v-card-text>やることを終わらせたら報酬を</v-card-text>
      </v-card>
    </v-timeline-item>
  </v-timeline>
</template>
