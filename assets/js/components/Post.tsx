import { Link } from "@inertiajs/react"
import React from "react"

import { Post as PostType } from "../types/post"
import { formatDate } from "../utils/date"

type Props = {
  post: PostType
}

export function Post({ post }: Props) {
  const date = formatDate(post.inserted_at)

  return (
    <article className="bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow p-6 max-w-2xl mx-auto mb-6">
      <header className="mb-4">
        <Link href={`/posts/${post.id}`} as="button">
          <h2 className="text-2xl font-bold text-gray-900 mb-2">
            {post.title}
          </h2>
        </Link>
        <div className="flex items-center text-sm text-gray-500">
          <span className="font-medium text-blue-600">
            @{post.user.username}
          </span>
          <span className="mx-2">•</span>
          <time dateTime={post.inserted_at}>{date}</time>
          <span className="mx-2">•</span>

          <div className="flex items-center gap-1">
            <span className="hero-heart-solid bg-red-500 size-4"></span>
            <span>{post.likes_count}</span>
          </div>
        </div>
      </header>

      <div className="prose prose-slate max-w-none">
        <p className="text-gray-700 whitespace-pre-wrap">{post.body}</p>
      </div>
    </article>
  )
}
