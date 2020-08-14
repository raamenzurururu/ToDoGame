import firebase from "@/plugins/firebase"
import axios from "@/plugins/axios"

const authCheck = ({ store, redirect }) => {
    firebase.auth().onAuthStateChanged(async user => {
        if (user) {
            const { data } = await axios.get(`/v1/users?uid=${user.uid}`)
            store.commit("setUser", {...data.user, todos: data.todos })
        } else {
            store.commit("setUser", null)
        }
    });
}

export default authCheck