import React from "react"

type Props = {
  color?: string
  className?: string
}

export function Loading({ color = "blue-500", className = "" }: Props) {
  return (
    <div className="flex items-center justify-center space-x-2">
      <div
        className={`border-4 border-${color} size-6 border-t-transparent border-solid rounded-full animate-spin ${className}`}
      ></div>
    </div>
  )
}
