import { Head, Link, useForm } from "@inertiajs/react"
import React from "react"

import { Button } from "../components/Button"
import { Input } from "../components/Input"

export default function Login() {
  const { post, processing, data, setData } = useForm({
    username: "",
    password: ""
  })

  function submit(event: React.FormEvent) {
    event.preventDefault()
    post("/login")
  }

  const loginDisabled = processing || !data.username || !data.password

  return (
    <>
      <Head>
        <title>Login | Threadit</title>
        <meta name="description" content="Login to your threadit account" />
      </Head>
      <div className="flex justify-center md:pt-[250px] pt-[180px]">
        <div className="bg-white drop-shadow p-10 rounded md:w-[500px] w-[90%]">
          <form onSubmit={submit} className="flex flex-col gap-4">
            <h1 className="text-center font-bold text-3xl mb-8">
              Welcome to Threadit
            </h1>
            <Input
              type="text"
              placeholder="username"
              required
              minLength={3}
              value={data.username}
              onChange={(e) => setData("username", e.target.value)}
            />

            <Input
              type="password"
              placeholder="password"
              minLength={8}
              maxLength={72}
              value={data.password}
              onChange={(e) => setData("password", e.target.value)}
              required
            />

            <Button type="submit" disabled={loginDisabled}>
              Login
            </Button>

            <p className="text-center">
              <span className="text-gray-600">Don't have an account?</span>{" "}
              <Link href="/register" className="text-blue-600">
                Register
              </Link>
            </p>
          </form>
        </div>
      </div>
    </>
  )
}
