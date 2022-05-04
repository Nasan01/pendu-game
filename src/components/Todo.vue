<script>
var id = 0
export default {
  props: ["theme"],
  data() {
    return {
      todos: [
        { content: "Learn HTML", done: true, id: id++ },
        { content: "Learn CSS", done: true, id: id++ },
        { content: "Lean JavaScript", done: true, id: id++ },
        { content: "Learn VueJs", done: false, id: id++ },
      ],
      text: "",
      hideCompletly: false,
    }
  },
  methods: {
    handleAddTodo() {
      if (this.text === "") {
        return;
      }
      this.todos.push({ content: this.text, done: false, id: id++ })
      this.text = ""
    },
    handleRemoveTodo(id) {
      this.todos = this.todos.filter(t => t.id !== id)
    },
  },
  computed: {
    filteredTodos() {
      return this.hideCompletly ? this.todos.filter(t => !t.done) : this.todos
    }
  }
}
</script>

<template>
  <div class="flex flex-col justify-center items-center ">
    <h1>Todo app about {{ theme }}</h1>
    <form @submit.prevent="handleAddTodo">
      <input type="text" name="todo" id="todo" v-model="text" ref="test"
        class="outline-none border-2 border-lime-500 px-3 py-2" required />
      <button class="bg-lime-500 border-2 border-lime-600 text-white px-4 py-2 mx-2 text-md">+</button>
    </form>
    <div class="flex flex-col justify-center">
      <ul>
        <li v-for="todo in filteredTodos" :key="todo.id" class="flex justify-between">
          <div>
            <input type="checkbox" name="done" id="done" v-model="todo.done"
              class="outline-none h-5 w-5 checked:bg-lime-900 cursor-pointer text-white" />
            <span :class="{ 'line-through': todo.done }" class="m-2">{{ todo.content }}</span>
          </div>
          <button class="bg-red-500 text-white px-2 m-2" @click="handleRemoveTodo(todo.id)">X</button>
        </li>
      </ul>
      <button class="px-3 py-2 bg-lime-500 text-white" @click="hideCompletly = !hideCompletly">
        {{ hideCompletly ? "Show All" : "Hide Completed" }}</button>
    </div>
  </div>
</template>
