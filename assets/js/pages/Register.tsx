import { Head, Link, useForm } from "@inertiajs/react"
import React from "react"

import { Button } from "../components/Button"
import { Input } from "../components/Input"

export default function Register() {
  const { post, processing, data, setData, errors, setError } = useForm({
    username: "",
    password: "",
    confirmPassword: ""
  })

  function submit(event: React.FormEvent) {
    event.preventDefault()

    if (data.password !== data.confirmPassword) {
      setError("confirmPassword", "Passwords do not match")
      return
    }

    post("/register")
  }

  const registerDisabled =
    processing || !data.username || !data.password || !data.confirmPassword

  return (
    <>
      <Head>
        <title>Register | Threadit</title>
        <meta name="description" content="Create your threadit account" />
      </Head>
      <div className="flex justify-center md:pt-[250px] pt-[180px]">
        <div className="bg-white drop-shadow p-10 rounded md:w-[500px] w-[90%]">
          <form onSubmit={submit} className="flex flex-col gap-4">
            <h1 className="text-center font-bold text-3xl mb-8">
              Create your account
            </h1>

            <Input
              type="text"
              placeholder="username"
              required
              minLength={3}
              value={data.username}
              onChange={(e) => setData("username", e.target.value)}
            />
            {errors.username && (
              <p className="text-red-500 text-sm">{errors.username}</p>
            )}

            <Input
              type="password"
              placeholder="password"
              minLength={8}
              maxLength={72}
              value={data.password}
              onChange={(e) => setData("password", e.target.value)}
              required
            />
            {errors.password && (
              <p className="text-red-500 text-sm">{errors.password}</p>
            )}

            <Input
              type="password"
              placeholder="confirm password"
              minLength={8}
              maxLength={72}
              value={data.confirmPassword}
              onChange={(e) => setData("confirmPassword", e.target.value)}
              required
            />
            {errors.confirmPassword && (
              <p className="text-red-500 text-sm">{errors.confirmPassword}</p>
            )}

            <Button type="submit" disabled={registerDisabled}>
              Register
            </Button>

            <p className="text-center">
              <span className="text-gray-600">Already have an account?</span>{" "}
              <Link href="/login" className="text-blue-600">
                Login
              </Link>
            </p>
          </form>
        </div>
      </div>
    </>
  )
}
