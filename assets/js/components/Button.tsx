import React from "react"

type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement> & {
  children: React.ReactNode
}

export function Button({ children, className, ...props }: ButtonProps) {
  return (
    <button
      className={`bg-blue-600 rounded text-white font-bold py-2 disabled:opacity-50 hover:opacity-90 transition-opacity ${className}`}
      {...props}
    >
      {children}
    </button>
  )
}
