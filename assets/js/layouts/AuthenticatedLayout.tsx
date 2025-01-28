import { Link, usePage } from "@inertiajs/react"
import React from "react"

import { User } from "../types/user"

type Props = {
  children: React.ReactNode
}

export function AuthenticatedLayout({ children }: Props) {
  const {
    props: { user }
  } = usePage<{ user: User }>()

  return (
    <>
      <nav className="bg-white drop-shadow flex text-2xl p-4">
        <Link href="/" className="font-bold">
          Threadit
        </Link>

        <Link href="/account" className="ml-auto mr-6">
          @{user.username}
        </Link>

        <Link href="/logout" method="post" as="button">
          logout
        </Link>
      </nav>
      {children}
    </>
  )
}
