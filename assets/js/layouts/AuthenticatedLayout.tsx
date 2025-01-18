import { Link, usePage } from "@inertiajs/react"
import React from "react"

export function AuthenticatedLayout({ children }) {
  const {
    props: { user }
  } = usePage<{ user: { id: string; username: string } }>()

  return (
    <>
      <nav className="bg-white drop-shadow flex text-2xl p-4">
        <Link href="/" className="font-bold">
          Threadit
        </Link>

        <Link href="/account" className="ml-auto mr-6">
          {user.username}
        </Link>

        <Link href="/logout" method="post" as="button">
          logout
        </Link>
      </nav>
      {children}
    </>
  )
}
