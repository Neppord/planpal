import { Elm } from './Main.elm'

if (module.hot) {
    module.hot.accept()
}

Elm.Main.init({node: document.body})