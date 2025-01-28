import React from "react"

import { Loading } from "./Loading"

type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement> & {
  children: React.ReactNode
  loading?: boolean
}

export function Button({
  children,
  className = "",
  loading = false,
  ...props
}: ButtonProps) {
  return (
    <button
      className={`bg-blue-600 rounded text-white font-bold py-2 disabled:opacity-50 hover:opacity-90 transition-opacity ${className}`}
      {...props}
    >
      {loading ? <Loading color="white" /> : children}
    </button>
  )
}
