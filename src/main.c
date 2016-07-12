int main(void) {
  while (1);
  return 0;
}

void _exit(int status) {
  (void) status;
  // hang forever
  while (1);
}
