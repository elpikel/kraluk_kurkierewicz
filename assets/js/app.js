// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
// If you have dependencies that try to import CSS, esbuild will generate a separate `app.css` file.
// To load it, simply add a second `<link>` to your `root.html.heex` file.

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
// import {Socket} from "phoenix"
// import {LiveSocket} from "phoenix_live_view"
// import {hooks as colocatedHooks} from "phoenix-colocated/kraluk_kurkierewicz"
// import topbar from "../vendor/topbar"

// const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// const liveSocket = new LiveSocket("/live", Socket, {
//   longPollFallbackMs: 2500,
//   params: {_csrf_token: csrfToken},
//   hooks: {...colocatedHooks},
// })

// Show progress bar on live navigation and form submits
// topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
// window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
// window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
// liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
// window.liveSocket = liveSocket

// The lines below enable quality of life phoenix_live_reload
// development features:
//
//     1. stream server logs to the browser console
//     2. click on elements to jump to their definitions in your code editor
//
// if (process.env.NODE_ENV === "development") {
//   window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
//     // Enable server log streaming to client.
//     // Disable with reloader.disableServerLogs()
//     reloader.enableServerLogs()
// 
//     // Open configured PLUG_EDITOR at file:line of the clicked element's HEEx component
//     //
//     //   * click with "c" key pressed to open at caller location
//     //   * click with "d" key pressed to open at function component definition location
//     let keyDown
//     window.addEventListener("keydown", e => keyDown = e.key)
//     window.addEventListener("keyup", _e => keyDown = null)
//     window.addEventListener("click", e => {
//       if(keyDown === "c"){
//         e.preventDefault()
//         e.stopImmediatePropagation()
//         reloader.openEditorAtCaller(e.target)
//       } else if(keyDown === "d"){
//         e.preventDefault()
//         e.stopImmediatePropagation()
//         reloader.openEditorAtDef(e.target)
//       }
//     }, true)
// 
//     window.liveReloader = reloader
//   })
// }


// Handle flash close
document.querySelectorAll("[role=alert][data-flash]").forEach((el) => {
  el.addEventListener("click", () => {
    el.setAttribute("hidden", "")
  })
})

// Kraluk Kurkierewicz home page interactions.
// Guarded so it is a no-op on pages that don't render these elements.
;(function () {
  const header = document.getElementById("header")
  const masthead = document.getElementById("masthead")
  const logoMini = document.getElementById("logo-mini")

  // Compact logo in the sticky bar once the full logo scrolls away
  if (header && masthead && "IntersectionObserver" in window) {
    new IntersectionObserver((entries) => {
      const stuck = !entries[0].isIntersecting
      header.toggleAttribute("data-stuck", stuck)
      if (logoMini) logoMini.tabIndex = stuck ? 0 : -1
    }).observe(masthead)
  }

  // Mobile menu
  const nav = document.getElementById("nav")
  const toggle = document.getElementById("nav-toggle")
  if (nav && toggle) {
    toggle.addEventListener("click", () => {
      const open = nav.toggleAttribute("data-open")
      toggle.setAttribute("aria-expanded", open)
    })
    nav.addEventListener("click", (e) => {
      if (e.target.closest("a")) {
        nav.removeAttribute("data-open")
        toggle.setAttribute("aria-expanded", "false")
      }
    })
  }

  // Blog: expand / collapse article
  document.querySelectorAll("[data-post-toggle]").forEach((btn) => {
    const body = document.getElementById(btn.getAttribute("aria-controls"))
    if (!body) return
    btn.addEventListener("click", () => {
      const open = body.hidden
      body.hidden = !open
      btn.setAttribute("aria-expanded", open)
      btn.textContent = open ? "Zwiń artykuł" : "Czytaj artykuł"
    })
  })

  // Contact form – sends the message through the backend (Brevo).
  const form = document.getElementById("contact-form")
  const status = document.getElementById("form-status")
  if (form && status) {
    const csrfToken = document
      .querySelector("meta[name='csrf-token']")
      ?.getAttribute("content")
    const submitBtn = form.querySelector("button[type='submit']")

    form.addEventListener("submit", async (e) => {
      e.preventDefault()

      const payload = Object.fromEntries(new FormData(form).entries())

      if (submitBtn) submitBtn.disabled = true
      status.hidden = true

      try {
        const res = await fetch("/api/kontakt", {
          method: "POST",
          headers: {
            "content-type": "application/json",
            accept: "application/json",
            "x-csrf-token": csrfToken,
          },
          body: JSON.stringify(payload),
        })
        const data = await res.json().catch(() => ({}))

        status.textContent =
          data.message ||
          (res.ok
            ? "Wiadomość wysłana. Dziękujemy!"
            : "Nie udało się wysłać wiadomości. Spróbuj ponownie.")

        if (res.ok) form.reset()
      } catch {
        status.textContent = "Nie udało się wysłać wiadomości. Spróbuj ponownie."
      } finally {
        status.hidden = false
        if (submitBtn) submitBtn.disabled = false
      }
    })
  }
})()