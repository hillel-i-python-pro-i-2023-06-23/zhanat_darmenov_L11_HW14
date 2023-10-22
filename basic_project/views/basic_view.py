# basic_project/views/basic_view.py

from django.shortcuts import render  # , redirect, get_object_or_404

# from django.urls import reverse


def main_page(request):
    page_name = {
        "page_name": "Home Page:",
    }

    if request.method == "POST":
        ...

    return render(request, "base.html", page_name)
