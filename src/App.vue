<script>

import Todo from './components/Todo.vue'
import Pendu from './components/pendu/Pendu.vue'

export default {
  data() {
    return {
      theme: "Daily Life !"
    }
  },
  components: {
    Todo,
    Pendu
  }
}

</script>

<template>
  <Pendu :theme="theme" />
</template>