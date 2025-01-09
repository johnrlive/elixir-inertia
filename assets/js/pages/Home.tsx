import React from "react"

export default function Home({ text }: { text: string }) {
  return (
    <div className="text-2xl">
      <h1>{text}</h1>
    </div>
  )
}
