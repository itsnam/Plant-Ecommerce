const FormValidate = (form) => {
  if (!form.name || !form.quantity || !form.price || !form.image) {
    return false;
  } else {
    return true;
  }
};

export default FormValidate;
