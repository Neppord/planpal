import { Elm } from './Main.elm'

if (module.hot) {
    module.hot.accept()
}

Elm.Main.init({node: document.body})
// hide adress bar on load for mobile
setTimeout(() => window.scrollTo(0,1), 500)
