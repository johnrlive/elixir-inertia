import { Head } from "@inertiajs/react"
import React from "react"

import { AuthenticatedLayout } from "../layouts/AuthenticatedLayout"

export default function Feed() {
  return (
    <AuthenticatedLayout>
      <Head>
        <title>Feed | Threadit</title>
        <meta
          name="description"
          content="See the latest posts from your friends"
        />
      </Head>
      <div className="text-2xl">
        <h1>Feed:</h1>
      </div>
    </AuthenticatedLayout>
  )
}
