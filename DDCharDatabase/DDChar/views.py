from django.shortcuts import render
from django.http import HttpResponse
from .models import *

# Create your views here.
def index(request):
    return HttpResponse("Hellow World, you are on DDChar.")

def getUser(request, userName):
    return HttpResponse("Welcome %s to the database." % userName)

def listUsers(request):
    user_list = User.objects.all()
    if len(user_list) > 1:
        return render(request, 'DDChar/userAll.html', {'user': user_list})
    else:
        return HttpResponse("No users.")

def getCharacter(request, charName, charRace, charLevel):
    response = "Your character stats are as follows: /n Name: %s /n Race: %s /n Level %s"
    return HttpResponse(response % charName, charRace, charLevel)