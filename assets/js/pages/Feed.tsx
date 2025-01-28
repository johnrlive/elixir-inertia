import { Head } from "@inertiajs/react"
import React from "react"

import { Post } from "../components/Post"
import { AuthenticatedLayout } from "../layouts/AuthenticatedLayout"
import { Post as PostType } from "../types/post"

type Props = {
  posts: PostType[]
}

export default function Feed({ posts }: Props) {
  return (
    <AuthenticatedLayout>
      <Head>
        <title>Feed | Threadit</title>
        <meta
          name="description"
          content="See the latest posts from your friends"
        />
      </Head>
      <div className="max-w-4xl mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-8 text-center">
          Your Feed
        </h1>

        <div className="space-y-6">
          {posts.map((post) => (
            <Post key={post.id} post={post} />
          ))}
        </div>
      </div>
    </AuthenticatedLayout>
  )
}
