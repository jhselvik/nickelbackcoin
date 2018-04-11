module.exports = {
    // required to lint *.vue files, do not add html here
    plugins: [
        'vue'
    ],
    extends: [
        'plugin:vue/recommended',
        'standard'
    ],
    env: {
        node: true
    },
    globals: {
        'artifacts': false
    }
}
