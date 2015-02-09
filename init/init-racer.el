(defcustom racer-cmd "/home/wooya/bin/racer"
  "Path to the racer binary."
  :type 'file
  :group 'racer)

(defcustom racer-rust-src-path
  (if (getenv "RUST_SRC_PATH")
      (getenv "RUST_SRC_PATH")
    "/home/wooya/rust/rust/src")
  "Path to the rust source tree."
  :type 'file
  :group 'racer)
