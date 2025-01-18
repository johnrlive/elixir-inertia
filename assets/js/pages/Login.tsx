import { Head, useForm } from "@inertiajs/react"
import React from "react"

export default function Login() {
  const { post, processing, data, setData } = useForm({
    username: "",
    password: ""
  })

  function submit(event: React.FormEvent) {
    event.preventDefault()
    post("/login")
  }

  return (
    <>
      <Head>
        <title>Login | Threadit</title>
        <meta name="description" content="Login to your threadit account" />
      </Head>
      <form onSubmit={submit} className="flex flex-col gap-2 max-w-xl">
        <input
          type="text"
          placeholder="username"
          required
          value={data.username}
          onChange={(e) => setData("username", e.target.value)}
        />
        <input
          type="password"
          placeholder="password"
          value={data.password}
          onChange={(e) => setData("password", e.target.value)}
          required
        />
        <button type="submit" disabled={processing}>
          Login
        </button>
      </form>
    </>
  )
}
