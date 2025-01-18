import { Link } from "@inertiajs/react"
import React from "react"

export function AuthenticatedLayout({ children }) {
  return (
    <>
      <nav className="bg-gray-500 flex text-2xl p-4">
        <Link href="/logout" method="post" as="button">
          Logout
        </Link>
      </nav>
      {children}
    </>
  )
}
