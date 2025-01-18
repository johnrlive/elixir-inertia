import React from "react"

type InputProps = React.InputHTMLAttributes<HTMLInputElement>

export function Input({ className, ...props }: InputProps) {
  return (
    <input
      className={`border border-gray-300 rounded p-2 placeholder:text-gray-400 ${className}`}
      {...props}
    />
  )
}
